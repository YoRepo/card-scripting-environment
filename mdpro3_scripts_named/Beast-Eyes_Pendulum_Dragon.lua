--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Beast-Eyes Pendulum Dragon  (ID: 72378329)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Dragon
-- Level: 8
-- ATK 3000 | DEF 2000
-- Setcode: 0x10f2
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 DARK Dragon monster + 1 Beast monster
-- Must be either Fusion Summoned, or Special Summoned by Tributing the above cards you control.
-- If this card destroys a monster by battle: Inflict damage to your opponent equal to the original ATK
-- of the Beast Fusion Material used for this card's Summon.
--[[ __CARD_HEADER_END__ ]]

--ビーストアイズ・ペンデュラム・ドラゴン
function c72378329.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c72378329.ffilter,aux.FilterBoolFunction(Card.IsRace,RACE_BEAST),true)
	aux.AddContactFusionProcedure(c,aux.FilterBoolFunction(Card.IsReleasable,REASON_SPSUMMON),LOCATION_MZONE,0,Duel.Release,REASON_SPSUMMON+REASON_MATERIAL)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(aux.bdcon)
	e3:SetTarget(c72378329.damtg)
	e3:SetOperation(c72378329.damop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MATERIAL_CHECK)
	e4:SetValue(c72378329.valcheck)
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4)
end
function c72378329.ffilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFusionAttribute(ATTRIBUTE_DARK)
end
function c72378329.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c72378329.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c72378329.valcheck(e,c)
	local g=c:GetMaterial():Filter(Card.IsRace,nil,RACE_BEAST)
	local atk=0
	if g:GetCount()>0 then
		atk=g:GetFirst():GetTextAttack()
		if atk<0 then atk=0 end
	end
	e:GetLabelObject():SetLabel(atk)
end
