--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Number C6: Chronomaly Chaos Atlandis  (ID: 6387204)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank: 7
-- ATK 3300 | DEF 3300
-- Setcode: 0x1048, 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 7 monsters
-- If you activate any of this card's effects, your opponent takes no further damage this turn.
-- Once per turn: You can target 1 monster your opponent controls; equip that target to this card as an
-- Equip Spell Card whose effect makes this monster gain 1000 ATK.
-- If this card has "Number 6: Chronomaly Atlandis" as an Xyz Material, it gains this effect.
-- ● You can detach 3 Xyz Materials from this card and send all "Number" monsters equipped by this
-- card's effect to the Graveyard (min. 1); make your opponent's Life Points 100.
--[[ __CARD_HEADER_END__ ]]

--CNo.6 先史遺産カオス・アトランタル
function c6387204.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6387204,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c6387204.eqtg)
	e1:SetOperation(c6387204.eqop)
	c:RegisterEffect(e1)
	--lp
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6387204,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c6387204.lpcon)
	e2:SetCost(c6387204.lpcost)
	e2:SetOperation(c6387204.lpop)
	c:RegisterEffect(e2)
end
aux.xyz_number[6387204]=6
function c6387204.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
end
function c6387204.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,tc,c,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c6387204.eqlimit)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetValue(1000)
		tc:RegisterEffect(e2)
		tc:RegisterFlagEffect(6387204,RESET_EVENT+RESETS_STANDARD,0,0)
	end
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CHANGE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetValue(0)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e4:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e4,tp)
end
function c6387204.eqlimit(e,c)
	return e:GetOwner()==c
end
function c6387204.lpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(1-tp)~=100 and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,9161357)
end
function c6387204.filter(c)
	return c:GetFlagEffect(6387204)~=0 and c:IsSetCard(0x48) and c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c6387204.lpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,3,REASON_COST)
		and e:GetHandler():GetEquipGroup():IsExists(c6387204.filter,1,nil) end
	e:GetHandler():RemoveOverlayCard(tp,3,3,REASON_COST)
	local g=e:GetHandler():GetEquipGroup():Filter(c6387204.filter,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c6387204.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,100)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
