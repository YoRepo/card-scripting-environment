--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Cyber Dragon Herz  (ID: 56364287)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level: 1
-- ATK 100 | DEF 100
-- Setcode: 0x1093
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's name becomes "Cyber Dragon" while on the field or in the GY.
-- You can only use 1 of the following effects of "Cyber Dragon Herz" per turn, and only once that
-- turn.
-- If this card is Special Summoned: You can make this card's Level become 5 until the end of this
-- turn, also, you cannot Special Summon for the rest of this turn, except Machine monsters.
-- If this card is sent to the GY: You can add 1 other "Cyber Dragon" from your Deck or GY to your
-- hand.
--[[ __CARD_HEADER_END__ ]]

--サイバー・ドラゴン・ヘルツ
function c56364287.initial_effect(c)
	--name change
	aux.EnableChangeCode(c,70095154,LOCATION_MZONE+LOCATION_GRAVE)
	--level change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56364287,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,56364287)
	e2:SetTarget(c56364287.lvtg)
	e2:SetOperation(c56364287.lvop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(56364287,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,56364287)
	e3:SetTarget(c56364287.thtg)
	e3:SetOperation(c56364287.thop)
	c:RegisterEffect(e3)
end
function c56364287.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsLevel(5) end
end
function c56364287.lvop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(5)
		c:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTargetRange(1,0)
	e2:SetLabelObject(e)
	e2:SetTarget(c56364287.splimit)
	Duel.RegisterEffect(e2,tp)
end
function c56364287.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsRace(RACE_MACHINE)
end
function c56364287.thfilter(c)
	return c:IsCode(70095154) and c:IsAbleToHand()
end
function c56364287.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56364287.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c56364287.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c56364287.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
