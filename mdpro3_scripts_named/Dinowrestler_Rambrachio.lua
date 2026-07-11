--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Dinowrestler Rambrachio  (ID: 61764082)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 5
-- ATK 1600 | DEF 0
-- Setcode: 0x11a
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your "Dinowrestler" monster inflicts battle damage to your opponent: You can Special Summon
-- this card from your hand in Defense Position.
-- You can only use this effect of "Dinowrestler Rambrachio" once per turn.
-- Your opponent cannot target other "Dinowrestler" monsters you control with card effects.
--[[ __CARD_HEADER_END__ ]]

--ダイナレスラー・ラアムブラキオ
function c61764082.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61764082,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,61764082)
	e1:SetCondition(c61764082.spcon)
	e1:SetTarget(c61764082.sptg)
	e1:SetOperation(c61764082.spop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c61764082.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end
function c61764082.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsControler(tp) and tc:IsSetCard(0x11a)
end
function c61764082.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c61764082.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c61764082.tgtg(e,c)
	return c~=e:GetHandler() and c:IsSetCard(0x11a)
end
