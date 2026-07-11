--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Ectoplasmer  (ID: 97342942)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during each player's End Phase: The turn player must Tribute 1 face-up monster, and
-- if they do, inflict damage to their opponent equal to half the original ATK of the Tributed monster.
--[[ __CARD_HEADER_END__ ]]

--エクトプラズマー
function c97342942.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--release
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(97342942,0))
	e2:SetCategory(CATEGORY_RELEASE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c97342942.condition)
	e2:SetTarget(c97342942.target)
	e2:SetOperation(c97342942.operation)
	c:RegisterEffect(e2)
end
function c97342942.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c97342942.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RELEASE,nil,1,tp,LOCATION_MZONE)
end
function c97342942.rfilter(c,e)
	return c:IsFaceup() and not c:IsImmuneToEffect(e)
end
function c97342942.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rg=Duel.SelectReleaseGroupEx(tp,c97342942.rfilter,1,1,REASON_EFFECT,false,e:GetHandler(),e)
	if Duel.Release(rg,REASON_EFFECT)>0 then
		local atk=math.floor(rg:GetFirst():GetBaseAttack()/2)
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end
