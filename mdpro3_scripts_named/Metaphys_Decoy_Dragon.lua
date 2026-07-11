--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Metaphys Decoy Dragon  (ID: 12196873)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Wyrm
-- Level: 2
-- ATK 300 | DEF 200
-- Pendulum Scale: L1 / R1
-- Setcode: 0x105
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 1
-- [ Pendulum Effect ]
-- When your monster is targeted for an attack: You can target 1 of your "Metaphys" monsters that is
-- banished or in your GY; banish this card, and if you do, Special Summon that monster in Attack
-- Position.
-- You can only use this effect of "Metaphys Decoy Dragon" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- When your monster is targeted for an attack: You can target 1 of your "Metaphys" monsters that is
-- banished or in your GY; banish this card, and if you do, Special Summon that monster in Attack
-- Position.
-- During the Standby Phase of the next turn after this card was banished: You can Special Summon this
-- banished card.
-- You can only use each effect of "Metaphys Decoy Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--メタファイズ・デコイドラゴン
function c12196873.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12196873,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,12196873)
	e1:SetCondition(c12196873.spcon1)
	e1:SetTarget(c12196873.sptg1)
	e1:SetOperation(c12196873.spop1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,12196874)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(12196873,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1,12196875)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetCondition(c12196873.spcon2)
	e3:SetTarget(c12196873.sptg2)
	e3:SetOperation(c12196873.spop2)
	c:RegisterEffect(e3)
end
function c12196873.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget() and Duel.GetAttackTarget():IsControler(tp)
end
function c12196873.spfilter(c,e,tp)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsSetCard(0x105) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c12196873.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c12196873.spfilter(chkc,e,tp) end
	if chk==0 then return c:IsAbleToRemove()
		and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingTarget(c12196873.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c12196873.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c12196873.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and Duel.Remove(c,POS_FACEUP,REASON_EFFECT)~=0
		and c:IsLocation(LOCATION_REMOVED) and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
function c12196873.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetHandler():GetTurnID()+1
end
function c12196873.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c12196873.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
