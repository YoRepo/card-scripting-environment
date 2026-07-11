--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Kickfire  (ID: 11501629)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, when a face-up FIRE monster(s) you control is destroyed by a card effect, place 1
-- counter on this card for each destroyed FIRE monster.
-- During either player's Standby Phase: You can send this card to the Graveyard; inflict 1000 damage
-- to your opponent for each counter on this card.
--[[ __CARD_HEADER_END__ ]]

--キックファイア
function c11501629.initial_effect(c)
	c:EnableCounterPermit(0x2d)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_DESTROY)
	e2:SetCondition(c11501629.ctcon)
	e2:SetOperation(c11501629.ctop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11501629,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(TIMING_STANDBY_PHASE)
	e3:SetCondition(c11501629.damcon)
	e3:SetCost(c11501629.damcost)
	e3:SetTarget(c11501629.damtg)
	e3:SetOperation(c11501629.damop)
	c:RegisterEffect(e3)
end
function c11501629.ctfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsReason(REASON_EFFECT)
end
function c11501629.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c11501629.ctfilter,nil,tp)
	if ct>0 and e:GetHandler():IsCanAddCounter(0x2d,ct) then
		e:SetLabel(ct)
		return true
	else
		return false
	end
end
function c11501629.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x2d,e:GetLabel())
end
function c11501629.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_STANDBY
end
function c11501629.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	e:SetLabel(e:GetHandler():GetCounter(0x2d))
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c11501629.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetCounter(0x2d)>0 end
	local dam=e:GetLabel()*1000
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c11501629.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
