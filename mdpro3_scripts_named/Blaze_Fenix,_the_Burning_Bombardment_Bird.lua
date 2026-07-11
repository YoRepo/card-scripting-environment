--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Blaze Fenix, the Burning Bombardment Bird  (ID: 6602300)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Pyro
-- Level: 8
-- ATK 2800 | DEF 2300
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Machine-Type monster + 1 Pyro-Type monster
-- Once per turn, during your Main Phase: You can inflict 300 damage to your opponent for each card on
-- the field.
-- This card cannot attack during the turn you activate this effect.
--[[ __CARD_HEADER_END__ ]]

--重爆撃禽 ボム・フェネクス
function c6602300.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE),aux.FilterBoolFunction(Card.IsRace,RACE_PYRO),true)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6602300,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c6602300.damcost)
	e2:SetTarget(c6602300.damtg)
	e2:SetOperation(c6602300.damop)
	c:RegisterEffect(e2)
end
function c6602300.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1,true)
end
function c6602300.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,0xc,0xc)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*300)
end
function c6602300.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(tp,0xc,0xc)
	Duel.Damage(p,ct*300,REASON_EFFECT)
end
