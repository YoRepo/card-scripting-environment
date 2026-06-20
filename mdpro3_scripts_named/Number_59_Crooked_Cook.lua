--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: No.59 背反之料理人  (ID: 82697249)
-- Type: Monster / Effect / Xyz
-- Attribute: FIRE
-- Race: Warrior
-- Rank 4
-- ATK 2300 | DEF 200
-- Setcode: 72
--
-- Effect Text:
-- 4星怪兽×2
-- ①：自己场上的卡只有这张卡的场合，这张卡不受其他卡的效果影响。
-- ②：1回合1次，把这张卡1个超量素材取除才能发动。这张卡以外的自己场上的卡全部破坏。那之后，这张卡的攻击力直到回合结束时上升这个效果破坏送去墓地的怪兽数量×300。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--No.59 背反の料理人
function c82697249.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c82697249.imcon)
	e1:SetValue(c82697249.efilter)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(82697249,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetCost(c82697249.descost)
	e2:SetTarget(c82697249.destg)
	e2:SetOperation(c82697249.desop)
	c:RegisterEffect(e2)
end
aux.xyz_number[82697249]=59
function c82697249.imcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_ONFIELD,0)==1
end
function c82697249.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c82697249.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c82697249.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c82697249.ctfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
end
function c82697249.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,0,aux.ExceptThisCard(e))
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
		local ct=Duel.GetOperatedGroup():FilterCount(c82697249.ctfilter,nil)
		if ct>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(ct*300)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	end
end
