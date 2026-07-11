--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Shiranui Spectralsword  (ID: 36630403)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Zombie
-- Level: 2
-- ATK 800 | DEF 0
-- Setcode: 0x10d9
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your GY, except the turn this card was sent to the GY: You can target 1 non-Tuner
-- Zombie monster in your GY; banish both it and this card, and if you do, Special Summon 1 Zombie
-- Synchro Monster from your Extra Deck whose Level equals the total Levels those 2 monsters had.
-- You can only use this effect of "Shiranui Spectralsword" once per turn.
--[[ __CARD_HEADER_END__ ]]

--妖刀－不知火
function c36630403.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,36630403)
	e1:SetCondition(aux.exccon)
	e1:SetTarget(c36630403.target)
	e1:SetOperation(c36630403.operation)
	c:RegisterEffect(e1)
end
function c36630403.filter1(c,e,tp,lv)
	local clv=c:GetLevel()
	return clv>0 and not c:IsType(TYPE_TUNER) and c:IsRace(RACE_ZOMBIE) and c:IsAbleToRemove()
		and Duel.IsExistingMatchingCard(c36630403.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,lv+clv)
end
function c36630403.filter2(c,e,tp,lv)
	return c:IsLevel(lv) and c:IsRace(RACE_ZOMBIE) and c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c36630403.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c36630403.filter1(chkc,e,tp,e:GetHandler():GetLevel()) end
	if chk==0 then return e:GetHandler():IsAbleToRemove()
		and Duel.IsExistingTarget(c36630403.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp,e:GetHandler():GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c36630403.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,e:GetHandler():GetLevel())
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c36630403.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local lv=c:GetLevel()+tc:GetLevel()
	local g=Group.FromCards(c,tc)
	if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c36630403.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv)
		if sg:GetCount()>0 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
