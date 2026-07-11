--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Performapal Laugh Maker  (ID: 44944304)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 8
-- ATK 2500 | DEF 2000
-- Pendulum Scale: L5 / R5
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 5
-- [ Pendulum Effect ]
-- Once per turn, if your opponent controls a monster whose current ATK is higher than its original
-- ATK: You can gain 1000 LP.
-- ----------------------------------------
-- [ Monster Effect ]
-- When this card declares an attack: You can make this card gain 1000 ATK for each monster on the
-- field whose current ATK is higher than its original ATK, except other monsters you control, until
-- the end of the Battle Phase.
-- If this card is destroyed by battle or card effect while its current ATK is higher than its original
-- ATK: You can target 1 monster in your Graveyard; Special Summon it.
-- You can only use 1 monster effect of "Performapal Laugh Maker" per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--EMラフメイカー
function c44944304.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44944304,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c44944304.rccon)
	e1:SetTarget(c44944304.rctg)
	e1:SetOperation(c44944304.rcop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44944304,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1,44944304)
	e2:SetCondition(c44944304.atkcon)
	e2:SetOperation(c44944304.atkop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(44944304,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,44944304)
	e3:SetCondition(c44944304.spcon)
	e3:SetTarget(c44944304.sptg)
	e3:SetOperation(c44944304.spop)
	c:RegisterEffect(e3)
end
function c44944304.rcfilter(c)
	return c:IsFaceup() and c:GetAttack()>c:GetBaseAttack()
end
function c44944304.rccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44944304.rcfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c44944304.rctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c44944304.rcop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c44944304.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return c44944304.rcfilter(e:GetHandler()) or Duel.IsExistingMatchingCard(c44944304.rcfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c44944304.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToBattle() or c:IsFacedown() then return end
	local ct=Duel.GetMatchingGroupCount(c44944304.rcfilter,tp,0,LOCATION_MZONE,nil)
	if c44944304.rcfilter(c) then ct=ct+1 end
	if ct>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000*ct)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c44944304.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT+REASON_BATTLE) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousAttackOnField()>c:GetBaseAttack()
end
function c44944304.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44944304.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp)
		and chkc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c44944304.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c44944304.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c44944304.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
