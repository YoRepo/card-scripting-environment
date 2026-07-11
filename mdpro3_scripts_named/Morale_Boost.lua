--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Morale Boost  (ID: 93671934)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time a player equips an Equip Spell Card, increase the Life Points of the controller of that
-- Equip Spell Card by 1000 points.
-- Each time an Equip Spell Card is removed from the field, the controller of that Equip Spell Card
-- takes 1000 points of damage.
--[[ __CARD_HEADER_END__ ]]

--士気高揚
function c93671934.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_EQUIP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c93671934.reccon)
	e2:SetTarget(c93671934.rectg)
	e2:SetOperation(c93671934.recop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c93671934.damcon)
	e3:SetTarget(c93671934.damtg)
	e3:SetOperation(c93671934.damop)
	c:RegisterEffect(e3)
end
function c93671934.reccon(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(eg:GetFirst():GetControler())
	return true
end
function c93671934.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,e:GetLabel(),1000)
end
function c93671934.recop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(e:GetLabel(),1000,REASON_EFFECT)
end
function c93671934.filter(c)
	return c:GetEquipTarget()~=nil or c:IsReason(REASON_LOST_TARGET)
end
function c93671934.damcon(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c93671934.filter,nil)
	if g:GetCount()==0 then return false end
	local flag=0
	if g:IsExists(Card.IsControler,1,nil,0) then flag=flag+1 end
	if g:IsExists(Card.IsControler,1,nil,1) then flag=flag+2 end
	e:SetLabel(({0,1,PLAYER_ALL})[flag])
	return true
end
function c93671934.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,e:GetLabel(),1000)
end
function c93671934.damop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()~=1-tp then
		Duel.Damage(tp,1000,REASON_EFFECT,true)
	end
	if e:GetLabel()~=tp then
		Duel.Damage(1-tp,1000,REASON_EFFECT,true)
	end
	Duel.RDComplete()
end
