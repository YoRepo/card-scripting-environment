--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Dragunity Couse  (ID: 29253591)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level: 2
-- ATK 1000 | DEF 200
-- Setcode: 0x29
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be used as Synchro Material, except for the Synchro Summon of a "Dragunity" monster.
-- This card on the field can be treated as a Level 4 monster when used for a Synchro Summon.
-- If this card is currently equipped to a monster: You can Special Summon this equipped card.
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－クーゼ
function c29253591.initial_effect(c)
	--synchro limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(c29253591.synlimit)
	c:RegisterEffect(e1)
	--synchro level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SYNCHRO_LEVEL)
	e2:SetValue(c29253591.slevel)
	c:RegisterEffect(e2)
	--special summon while equipped
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(29253591,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c29253591.sptg)
	e3:SetOperation(c29253591.spop)
	c:RegisterEffect(e3)
end
function c29253591.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x29)
end
function c29253591.slevel(e,c)
	local lv=aux.GetCappedLevel(e:GetHandler())
	return (4<<16)+lv
end
function c29253591.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:GetEquipTarget() and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c29253591.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
