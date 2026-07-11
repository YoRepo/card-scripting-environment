--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Number C62: Neo Galaxy-Eyes Prime Photon Dragon  (ID: 48348921)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Dragon
-- Rank: 8
-- ATK 4000 | DEF 3000
-- Setcode: 0x1048, 0x107b, 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 8 LIGHT monsters
-- You can also Xyz Summon this card by using "Number 62: Galaxy-Eyes Prime Photon Dragon" you control.
-- (Transfer its materials to this card.)
-- At the start of your Battle Phase: You can detach 1 material from this card; this card can make up
-- to 3 attacks on monsters during this Battle Phase.
-- If this card has "Galaxy-Eyes Photon Dragon" as material, it gains these effects.
-- ● Unaffected by your opponent's monster effects.
-- ● Gains ATK equal to the combined Levels/Ranks of its attached materials x 100.
--[[ __CARD_HEADER_END__ ]]

--CNo.62 超銀河眼の光子龍皇
function c48348921.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),8,3,c48348921.ovfilter,aux.Stringid(48348921,1))
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48348921,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c48348921.atkcon)
	e1:SetCost(c48348921.atkcost)
	e1:SetTarget(c48348921.atktg)
	e1:SetOperation(c48348921.atkop)
	c:RegisterEffect(e1)
	--immune monster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c48348921.econ)
	e2:SetValue(c48348921.efilter)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c48348921.econ)
	e3:SetValue(c48348921.atkval)
	c:RegisterEffect(e3)
end
aux.xyz_number[48348921]=62
function c48348921.ovfilter(c)
	return c:IsFaceup() and c:IsCode(31801517)
end
function c48348921.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c48348921.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c48348921.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)==0 end
end
function c48348921.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c48348921.econ(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,93717133)
end
function c48348921.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c48348921.atkval(e,c)
	return c:GetOverlayGroup():GetSum(c48348921.lv_or_rk)*100
end
function c48348921.lv_or_rk(c)
	if c:IsType(TYPE_XYZ) then return c:GetRank()
	else return c:GetLevel() end
end
