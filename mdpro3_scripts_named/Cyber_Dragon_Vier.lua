--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Cyber Dragon Vier  (ID: 29975188)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level: 4
-- ATK 1100 | DEF 1600
-- Setcode: 0x1093
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's name becomes "Cyber Dragon" while on the field or in the GY.
-- If you Normal or Special Summon "Cyber Dragon", except during the Damage Step: You can Special
-- Summon this card from your hand in Defense Position.
-- You can only use this effect of "Cyber Dragon Vier" once per turn.
-- Each "Cyber Dragon" you control gains 500 ATK/DEF.
--[[ __CARD_HEADER_END__ ]]

--サイバー・ドラゴン・フィーア
function c29975188.initial_effect(c)
	--code
	aux.EnableChangeCode(c,70095154,LOCATION_MZONE+LOCATION_GRAVE)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29975188,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,29975188)
	e2:SetCondition(c29975188.spcon)
	e2:SetTarget(c29975188.sptg)
	e2:SetOperation(c29975188.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsCode,70095154))
	e4:SetValue(500)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
end
function c29975188.cfilter(c,tp)
	return c:IsFaceup() and c:IsCode(70095154) and c:IsSummonPlayer(tp)
end
function c29975188.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c29975188.cfilter,1,nil,tp)
end
function c29975188.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29975188.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
