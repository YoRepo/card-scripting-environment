--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 皇之波动  (ID: 59070329)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的1个超量素材取除发动。自己场上表侧表示存在的超量怪兽直到结束阶段时不会被卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--皇の波動
function c59070329.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c59070329.cost)
	e1:SetTarget(c59070329.target)
	e1:SetOperation(c59070329.activate)
	c:RegisterEffect(e1)
end
function c59070329.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,0,1,REASON_COST) end
	Duel.RemoveOverlayCard(tp,1,0,1,1,REASON_COST)
end
function c59070329.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c59070329.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c59070329.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c59070329.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c59070329.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
