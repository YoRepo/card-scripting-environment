--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 强化空间  (ID: 11224934)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的全部超量怪兽的攻击力直到结束阶段时上升那怪兽的超量素材每1个300。
--[[ __CARD_HEADER_END__ ]]

--強化空間
function c11224934.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c11224934.target)
	e1:SetOperation(c11224934.activate)
	c:RegisterEffect(e1)
end
function c11224934.filter(c)
	return c:IsFaceup() and c:GetOverlayCount()~=0
end
function c11224934.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11224934.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c11224934.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c11224934.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetOverlayCount()*300)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
