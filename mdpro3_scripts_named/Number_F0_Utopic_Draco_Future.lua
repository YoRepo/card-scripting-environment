--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Number F0: Utopic Draco Future  (ID: 26973555)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank: 1
-- ATK 3000 | DEF 2000
-- Setcode: 0x48, 0x207f
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Xyz Monsters with the same Rank, except "Number" monsters
-- (This card's original Rank is always treated as 1. This card is always treated as a "Utopic Future"
-- card.)
-- You can also Xyz Summon this card by using "Number F0: Utopic Future" you control as material.
-- (Transfer its materials to this card.)
-- Cannot be destroyed by battle or card effects.
-- Once per turn, when your opponent activates a monster effect (Quick Effect): You can detach 1
-- material from this card; negate the activation, then, if that monster is on the field, gain control
-- of it.
--[[ __CARD_HEADER_END__ ]]

--FNo.0 未来龍皇ホープ
function c26973555.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedureLevelFree(c,c26973555.mfilter,c26973555.xyzcheck,3,3,c26973555.ovfilter,aux.Stringid(26973555,0))
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26973555,1))
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c26973555.discon)
	e3:SetCost(c26973555.discost)
	e3:SetTarget(c26973555.distg)
	e3:SetOperation(c26973555.disop)
	c:RegisterEffect(e3)
end
aux.xyz_number[26973555]=0
function c26973555.mfilter(c,xyzc)
	return c:IsXyzType(TYPE_XYZ) and not c:IsSetCard(0x48)
end
function c26973555.xyzcheck(g)
	return g:GetClassCount(Card.GetRank)==1
end
function c26973555.ovfilter(c)
	return c:IsFaceup() and c:IsCode(65305468)
end
function c26973555.discon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER) and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and Duel.IsChainNegatable(ev)
end
function c26973555.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c26973555.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetCategory(CATEGORY_NEGATE)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_MZONE and re:GetHandler():IsRelateToEffect(re)
		and not re:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then
		e:SetCategory(CATEGORY_NEGATE+CATEGORY_CONTROL)
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,eg,1,0,0)
	end
end
function c26973555.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_MZONE
		and re:GetHandler():IsRelateToEffect(re) and not re:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then
		Duel.BreakEffect()
		Duel.GetControl(re:GetHandler(),tp)
	end
end
