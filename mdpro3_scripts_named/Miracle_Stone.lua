--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Miracle Stone  (ID: 31461282)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only control 1 "Miracle Stone".
-- All Spellcaster monsters you control gain 500 ATK/DEF for each "Fortune Fairy" monster you control
-- with different names.
-- Once per turn, when an attack is declared involving your "Fortune Fairy" monster: You can draw 1
-- card.
--[[ __CARD_HEADER_END__ ]]

--開運ミラクルストーン
function c31461282.initial_effect(c)
	c:SetUniqueOnField(1,0,31461282)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_SPELLCASTER))
	e1:SetValue(c31461282.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(31461282,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c31461282.drcon)
	e3:SetTarget(c31461282.drtg)
	e3:SetOperation(c31461282.drop)
	c:RegisterEffect(e3)
end
function c31461282.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x12e)
end
function c31461282.atkval(e,c)
	local g=Duel.GetMatchingGroup(c31461282.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
	return g:GetClassCount(Card.GetCode)*500
end
function c31461282.drcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a:IsControler(tp) and a:IsSetCard(0x12e)) or (d and d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x12e))
end
function c31461282.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c31461282.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
