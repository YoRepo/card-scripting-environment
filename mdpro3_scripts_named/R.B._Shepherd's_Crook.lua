--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 奏悦机组 牧羊人权杖  (ID: 80071619)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Machine
-- ATK 1500 | LINK
-- Setcode: 463
--
-- Effect Text:
-- 包含「奏悦机组」怪兽的怪兽2只以上
-- 这张卡的攻击力上升这张卡以外的自己怪兽的数量×500。
-- 「奏悦机组 牧羊人权杖」的以下效果1回合各能使用1次。
-- 自己主要阶段：可以从自己的卡组·墓地把1张「奏悦机组」陷阱卡在自己场上盖放。
-- 对方主要阶段（诱发即时效果）：可以以自己墓地的3只3星以上的「奏悦机组」怪兽为对象；那之内的2只用喜欢的顺序回到卡组最下面，剩下的守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--R.B. Shepherd's Crook
local s,id,o=GetID()
function s.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,3,s.lcheck)
	--gain ATK
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(s.atkval)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.settg)
	e2:SetOperation(s.setop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1,id+o)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e3:SetCondition(s.spcon)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
end
function s.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x1cf)
end
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(aux.TRUE,c:GetControler(),LOCATION_MZONE,0,e:GetHandler())*500
end
function s.setfilter(c)
	return c:IsSetCard(0x1cf) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(s.setfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.setfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.SSet(tp,tc)
	end
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.IsMainPhase()
end
function s.tdfilter(c,e,tp)
	return c:IsSetCard(0x1cf) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeEffectTarget(e) and c:IsLevelAbove(3)
		and (c:IsAbleToDeck() or c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE))
end
function s.fselect(g,e,tp)
	return g:IsExists(Card.IsAbleToDeck,2,nil) and g:IsExists(Card.IsCanBeSpecialSummoned,1,nil,e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local dg=Duel.GetMatchingGroup(s.tdfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if chkc then return false end
	if chk==0 then return dg:CheckSubGroup(s.fselect,3,3,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=dg:SelectSubGroup(tp,s.fselect,false,3,3,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function s.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function s.fselect2(g,e,tp,sg)
	local ag=sg:Clone()
	ag:Sub(g)
	return g:IsExists(Card.IsAbleToDeck,2,nil) and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and ag:IsExists(Card.IsCanBeSpecialSummoned,1,nil,e,0,tp,false,false,POS_FACEUP_DEFENSE)
		or not sg:IsExists(Card.IsCanBeSpecialSummoned,1,nil,e,0,tp,false,false,POS_FACEUP_DEFENSE)
		or Duel.GetLocationCount(tp,LOCATION_MZONE)==0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(aux.NecroValleyFilter(Card.IsRelateToChain),nil)
	if tg:GetCount()<2 then
		return
	elseif tg:GetCount()==2 and tg:IsExists(Card.IsAbleToDeck,2,nil) then
		aux.PlaceCardsOnDeckBottom(tp,tg)
	elseif tg:GetCount()>2 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local sg=tg:SelectSubGroup(tp,s.fselect2,false,2,2,e,tp,tg)
		if sg:GetCount()>0 then
			tg:Sub(sg)
			Duel.HintSelection(sg)
			aux.PlaceCardsOnDeckBottom(tp,sg)
			local og=Duel.GetOperatedGroup()
			if not og:IsExists(Card.IsLocation,1,nil,LOCATION_DECK+LOCATION_EXTRA) then return end
			local tc=tg:GetFirst()
			if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
				and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) then
				Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			end
		end
	end
end
