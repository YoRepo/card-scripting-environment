--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Black Shadow Squall  (ID: 96367119)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Spell/Trap Card is activated: Remove 1 Black Feather Counter from your field; negate the
-- activation, and if you do, destroy that card.
-- If you control "Black-Winged Dragon": You can Set this card from your GY, but banish it when it
-- leaves the field.
-- You can only use 1 "Black Shadow Squall" effect per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--ブラック・ノーブル
function c96367119.initial_effect(c)
	aux.AddCodeList(c,9012916)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96367119,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,96367119)
	e1:SetCondition(c96367119.discon)
	e1:SetCost(c96367119.discost)
	e1:SetTarget(c96367119.distg)
	e1:SetOperation(c96367119.disop)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96367119,1))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,96367119)
	e2:SetCondition(c96367119.setcon)
	e2:SetTarget(c96367119.settg)
	e2:SetOperation(c96367119.setop)
	c:RegisterEffect(e2)
end
function c96367119.discon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c96367119.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x10,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x10,1,REASON_COST)
end
function c96367119.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c96367119.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c96367119.setfilter(c)
	return c:IsCode(9012916) and c:IsFaceup()
end
function c96367119.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c96367119.setfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c96367119.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsSSetable() end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c96367119.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SSet(tp,c)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
end
