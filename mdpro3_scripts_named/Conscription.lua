--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 征兵令  (ID: 31000575)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 检视对方卡组最上面的1张卡，如果那张卡是可以通常召唤的怪兽的场合，在自己场上特殊召唤。是其他卡的场合，那张卡加到对方的手卡。
--[[ __CARD_HEADER_END__ ]]

--徴兵令
function c31000575.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c31000575.target)
	e1:SetOperation(c31000575.operation)
	c:RegisterEffect(e1)
end
function c31000575.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)~=0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsPlayerAffectedByEffect(tp,63060238)
		and not Duel.IsPlayerAffectedByEffect(tp,97148796) end
end
function c31000575.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(1-tp,1)
	local g=Duel.GetDecktopGroup(1-tp,1)
	local tc=g:GetFirst()
	if not tc then return end
	if tc:IsSummonableCard() and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.DisableShuffleCheck()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	elseif tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	else
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_RULE)
	end
end
