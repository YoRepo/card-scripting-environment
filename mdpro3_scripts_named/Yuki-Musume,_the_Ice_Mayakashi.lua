--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Yuki-Musume, the Ice Mayakashi  (ID: 72700231)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Zombie
-- Level: 1
-- ATK 0 | DEF 1900
-- Setcode: 0x121
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Mayakashi" card, other than "Yuki-Musume, the Ice Mayakashi" while this card is in
-- your hand or GY: You can Special Summon this card, then send 1 Zombie monster from your Deck to the
-- GY.
-- You can only use this effect of "Yuki-Musume, the Ice Mayakashi" once per turn.
-- You cannot Special Summon monsters from the Extra Deck, except "Mayakashi" monsters.
--[[ __CARD_HEADER_END__ ]]

--氷の魔妖－雪娘
function c72700231.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72700231,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,72700231)
	e1:SetCondition(c72700231.condition)
	e1:SetTarget(c72700231.target)
	e1:SetOperation(c72700231.operation)
	c:RegisterEffect(e1)
	--spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c72700231.sslimit)
	c:RegisterEffect(e2)
end
function c72700231.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x121) and not c:IsCode(72700231)
end
function c72700231.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c72700231.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c72700231.tgfilter(c)
	return c:IsRace(RACE_ZOMBIE) and c:IsAbleToGrave()
end
function c72700231.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c72700231.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c72700231.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c72700231.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end
end
function c72700231.sslimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsSetCard(0x121)
end
