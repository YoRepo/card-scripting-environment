--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Vahram, the Magistus Divinity Dragon  (ID: 61272280)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Dragon
-- Level: 8
-- ATK 2500 | DEF 2900
-- Setcode: 0x150
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner monsters
-- While this card is an Equip Card, the equipped monster cannot be destroyed by your opponent's
-- Spell/Trap effects.
-- You can only use each of the following effects of "Vahram, the Magistus Divinity Dragon" once per
-- turn.
-- If this Synchro Summoned card is destroyed: You can destroy all face-up cards your opponent
-- controls.
-- At the start of the Damage Step, if the monster this card is equipped to battles an opponent's
-- monster: You can destroy that opponent's monster.
--[[ __CARD_HEADER_END__ ]]

--絶火の竜神ヴァフラム
function c61272280.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy(destroyed)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61272280,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,61272280)
	e1:SetCondition(c61272280.descon)
	e1:SetTarget(c61272280.destg)
	e1:SetOperation(c61272280.desop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(c61272280.indesval)
	c:RegisterEffect(e2)
	--destroy(equip)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(61272280,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,61272281)
	e3:SetCondition(c61272280.descon2)
	e3:SetTarget(c61272280.destg2)
	e3:SetOperation(c61272280.desop2)
	c:RegisterEffect(e3)
end
function c61272280.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c61272280.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_ONFIELD,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c61272280.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_ONFIELD,nil)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c61272280.indesval(e,re,rp)
	return aux.tgoval(e,re,rp) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c61272280.descon2(e,tp,eg,ep,ev,re,r,rp)
	local etc=e:GetHandler():GetEquipTarget()
	if not etc then return false end
	local bc=etc:GetBattleTarget()
	e:SetLabelObject(bc)
	return bc and bc:IsControler(1-tp) and bc:IsRelateToBattle()
end
function c61272280.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if chk==0 then return bc end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c61272280.desop2(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc and bc:IsControler(1-tp) and bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
