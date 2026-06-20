--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 装弹枪管解放龙  (ID: 27096833)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Dragon
-- ATK 3000 | LINK
-- Setcode: 271
--
-- Effect Text:
-- 效果怪兽3只以上
-- 自己对「装弹枪管解放龙」1回合只能有1次特殊召唤。
-- ①：1回合1次，自己·对方的战斗阶段才能发动（对方不能对应这个发动把卡的效果发动）。对方场上1只怪兽在这张卡所连接区放置得到控制权。
-- ②：自己·对方回合，这张卡在墓地存在的场合，以自己场上1只怪兽为对象才能发动（同一连锁上最多1次）。那只怪兽破坏，这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ヴァレルロード・L・ドラゴン
local s,id,o=GetID()
function s.initial_effect(c)
	c:SetSPSummonOnce(id)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),3)
	c:EnableReviveLimit()
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(TIMING_BATTLE_START+TIMING_BATTLE_END+TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1)
	e1:SetCondition(s.cocon)
	e1:SetTarget(s.cotg)
	e1:SetOperation(s.coop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.cocon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase()
end
function s.cfilter(c,ec)
	local zone=bit.band(ec:GetLinkedZone(),0x1f)
	return c:IsControlerCanBeChanged(false,zone)
end
function s.cotg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		return Duel.IsExistingMatchingCard(s.cfilter,tp,0,LOCATION_MZONE,1,nil,c)
	end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,0,0)
	Duel.SetChainLimit(s.chlimit)
end
function s.chlimit(e,ep,tp)
	return tp==ep
end
function s.coop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,s.cfilter,tp,0,LOCATION_MZONE,1,1,nil,c)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local zone=bit.band(c:GetLinkedZone(),0x1f)
		Duel.GetControl(tc,tp,0,0,zone)
	end
end
function s.tfilter(c,tp)
	return Duel.GetMZoneCount(tp,c)>0
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.tfilter(chkc,tp) end
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(s.tfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,s.tfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() and tc:IsType(TYPE_MONSTER) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local c=e:GetHandler()
		if c:IsRelateToChain() and aux.NecroValleyFilter()(c) then
			Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
