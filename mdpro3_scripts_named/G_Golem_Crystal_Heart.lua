--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: G Golem Crystal Heart  (ID: 61668670)
-- Type: Monster / Effect / Link
-- Attribute: WATER
-- Race: Cyberse
-- Link Rating: 2
-- Link Arrows: Left, Bottom
-- ATK 0
-- Setcode: 0x186
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Cyberse monsters
-- You can target 1 EARTH Link Monster in your GY; Special Summon it to your zone this card points to,
-- and if you do, place 1 GG Counter on this card.
-- You can only use this effect of "G Golem Crystal Heart" once per turn.
-- EARTH monsters co-linked to this card gain 600 ATK for each GG Counter on this card, can make a
-- second attack during each Battle Phase, also if they attack a Defense Position monster, inflict
-- piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--Gゴーレム・クリスタルハート
function c61668670.initial_effect(c)
	c:EnableCounterPermit(0x64)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,2)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61668670,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,61668670)
	e1:SetTarget(c61668670.sptg)
	e1:SetOperation(c61668670.spop)
	c:RegisterEffect(e1)
	--atk gain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c61668670.atkcon)
	e2:SetTarget(c61668670.atktg)
	e2:SetValue(c61668670.atkval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e4)
end
function c61668670.filter(c,e,tp,zone)
	return c:IsAttribute(ATTRIBUTE_EARTH) and c:IsType(TYPE_LINK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c61668670.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local zone=e:GetHandler():GetLinkedZone(tp)&0x1f
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c61668670.filter(chkc,e,tp,zone) end
	if chk==0 then return Duel.IsExistingTarget(c61668670.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c61668670.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,zone)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c61668670.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local zone=c:GetLinkedZone(tp)&0x1f
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and zone~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP,zone)
		c:AddCounter(0x64,1)
	end
end
function c61668670.atkcon(e)
	return e:GetHandler():GetMutualLinkedGroupCount()>0
end
function c61668670.atktg(e,c)
	local g=e:GetHandler():GetMutualLinkedGroup()
	return g:IsContains(c) and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c61668670.atkval(e,c)
	return e:GetHandler():GetCounter(0x64)*600
end
