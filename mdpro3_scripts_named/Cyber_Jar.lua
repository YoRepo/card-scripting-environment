--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 电子壶  (ID: 34124316)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Rock
-- Level 3
-- ATK 900 | DEF 900
-- Setcode: 147
--
-- Effect Text:
-- ①：这张卡反转的场合发动。场上的怪兽全部破坏。那之后，双方从卡组上面把5张卡翻开，那之中的4星以下而可以特殊召唤的怪兽全部表侧攻击表示或里侧守备表示特殊召唤。剩下的翻开的卡全部加入手卡。
--[[ __CARD_HEADER_END__ ]]

--サイバーポッド
function c34124316.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c34124316.target)
	e1:SetOperation(c34124316.operation)
	c:RegisterEffect(e1)
end
function c34124316.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c34124316.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local g1=Duel.GetDecktopGroup(tp,5)
	local g2=Duel.GetDecktopGroup(1-tp,5)
	local hg=Group.CreateGroup()
	local gg=Group.CreateGroup()
	Duel.ConfirmDecktop(tp,5)
	local tc=g1:GetFirst()
	while tc do
		if tc:IsLevelBelow(4) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE) then
			Duel.DisableShuffleCheck()
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)
		elseif tc:IsAbleToHand() then
			hg:AddCard(tc)
		else gg:AddCard(tc) end
		tc=g1:GetNext()
	end
	Duel.ConfirmDecktop(1-tp,5)
	tc=g2:GetFirst()
	while tc do
		if tc:IsLevelBelow(4) and tc:IsCanBeSpecialSummoned(e,0,1-tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE) then
			Duel.DisableShuffleCheck()
			Duel.SpecialSummonStep(tc,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)
		elseif tc:IsAbleToHand() then
			hg:AddCard(tc)
		else gg:AddCard(tc) end
		tc=g2:GetNext()
	end
	if hg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(hg,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
		Duel.ShuffleHand(1-tp)
	end
	if gg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(gg,REASON_EFFECT)
	end
	Duel.SpecialSummonComplete()
end
