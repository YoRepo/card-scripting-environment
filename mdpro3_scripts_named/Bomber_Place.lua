--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 炸弹数独家  (ID: 71750854)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 1350 | DEF 2400
--
-- Effect Text:
-- ①：自己·对方回合，可以支付600基本分，从以下选择1个发动（同一连锁上最多1次）。
-- ●自己场上有1～6星的怪兽全部存在的场合才能发动。选对方场上1只表侧表示怪兽，等级·阶级·连接的数值和那个等级相同的除选的怪兽以外的对方场上的怪兽全部破坏。
-- ●选自己场上1只表侧表示怪兽，等级·阶级·连接的数值和那个等级相同的位于选的怪兽的正对面的对方怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--ボンバー・プレイス
local s,id,o=GetID()
function s.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(s.descost)
	e1:SetTarget(s.destg)
	e1:SetOperation(s.desop)
	c:RegisterEffect(e1)
end
function s.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,600) end
	Duel.PayLPCost(tp,600)
end
function s.descon1(tp)
	local g=Duel.GetMatchingGroup(aux.AND(Card.IsFaceup,Card.IsLevelBelow),tp,LOCATION_MZONE,0,nil,6)
	local lvc=0
	for tc in aux.Next(g) do
		lvc=lvc|(1<<(tc:GetLevel()-1))
	end
	return lvc==0x3f
end
function s.tgfilter1(c,tp)
	return c:IsFaceup() and c:IsLevelAbove(1)
		and Duel.IsExistingMatchingCard(s.desfilter1,tp,0,LOCATION_MZONE,1,c,c:GetLevel())
end
function s.desfilter1(c,lv)
	return c:IsFaceup() and (c:IsLevel(lv) or c:IsRank(lv) or c:IsLink(lv))
end
function s.tgfilter2(c,tp)
	return c:IsFaceup() and c:IsLevelAbove(1)
		and c:GetColumnGroup():FilterCount(s.desfilter2,nil,tp,c:GetLevel())>0
end
function s.desfilter2(c,tp,lv)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsControler(1-tp) and (c:IsLevel(lv) or c:IsRank(lv) or c:IsLink(lv))
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=s.descon1(tp) and Duel.IsExistingMatchingCard(s.tgfilter1,tp,0,LOCATION_MZONE,1,nil,tp)
	local b2=Duel.IsExistingMatchingCard(s.tgfilter2,tp,LOCATION_MZONE,0,1,nil,tp)
	if chk==0 then return b1 or b2 end
	local label=aux.SelectFromOptions(tp,
		{b1,aux.Stringid(id,0),1},
		{b2,aux.Stringid(id,1),2})
	e:SetLabel(label)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local label=e:GetLabel()
	if label==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
		local g=Duel.SelectMatchingCard(tp,s.tgfilter1,tp,0,LOCATION_MZONE,1,1,nil,tp)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local sg=Duel.GetMatchingGroup(s.desfilter1,tp,0,LOCATION_MZONE,g,g:GetFirst():GetLevel())
			Duel.Destroy(sg,POS_FACEUP,REASON_EFFECT)
		end
	elseif label==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
		local g=Duel.SelectMatchingCard(tp,s.tgfilter2,tp,LOCATION_MZONE,0,1,1,nil,tp)
		if g:GetCount()>0 then
			local tc=g:GetFirst()
			Duel.HintSelection(g)
			local dg=tc:GetColumnGroup():Filter(s.desfilter2,nil,tp,tc:GetLevel())
			Duel.Destroy(dg,POS_FACEUP,REASON_EFFECT)
		end
	end
end
