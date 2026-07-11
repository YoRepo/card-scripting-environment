--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Ruin, Supreme Queen of Oblivion  (ID: 13518809)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 10
-- ATK 2900 | DEF 3000
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Cycle of the World".
-- This card's name becomes "Ruin, Queen of Oblivion" while in the hand or on the field.
-- While this Ritual Summoned card is on the field, Ritual Monsters you control cannot be destroyed by
-- card effects.
-- If all monsters used to Ritual Summon this card were Ritual Monsters, it can make a second attack
-- during each Battle Phase.
-- If this card destroys an opponent's monster by battle: You can inflict damage to your opponent equal
-- to that destroyed monster's original ATK.
--[[ __CARD_HEADER_END__ ]]

--破滅の美神ルイン
function c13518809.initial_effect(c)
	aux.AddCodeList(c,32828635)
	c:EnableReviveLimit()
	--code
	aux.EnableChangeCode(c,46427957,LOCATION_MZONE+LOCATION_HAND)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c13518809.indcon)
	e2:SetTarget(c13518809.indtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetCondition(c13518809.condition)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(aux.bdocon)
	e4:SetTarget(c13518809.damtg)
	e4:SetOperation(c13518809.damop)
	c:RegisterEffect(e4)
	--material check
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetCondition(c13518809.matcon)
	e5:SetOperation(c13518809.matop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_MATERIAL_CHECK)
	e6:SetValue(c13518809.valcheck)
	e6:SetLabelObject(e5)
	c:RegisterEffect(e6)
end
function c13518809.indcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c13518809.indtg(e,c)
	return c:IsType(TYPE_RITUAL)
end
function c13518809.mfilter(c)
	return not c:IsType(TYPE_RITUAL)
end
function c13518809.condition(e)
	return e:GetHandler():GetFlagEffect(13518809)>0
end
function c13518809.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetBattleTarget()
	local atk=tc:GetBaseAttack()
	if atk<0 then atk=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c13518809.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c13518809.matcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL) and e:GetLabel()==1
end
function c13518809.matop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(13518809,RESET_EVENT+RESETS_STANDARD,0,1)
end
function c13518809.valcheck(e,c)
	local g=c:GetMaterial()
	if g:GetCount()>0 and not g:IsExists(c13518809.mfilter,1,nil) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
