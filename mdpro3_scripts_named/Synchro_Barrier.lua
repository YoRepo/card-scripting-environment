--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 同调障壁  (ID: 21879581)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 23
--
-- Effect Text:
-- 把自己场上存在的1只同调怪兽解放发动。直到下个回合的结束阶段时，自己受到的全部伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--シンクロ・バリアー
function c21879581.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c21879581.cost)
	e1:SetOperation(c21879581.activate)
	c:RegisterEffect(e1)
end
function c21879581.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsType,1,nil,TYPE_SYNCHRO) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsType,1,1,nil,TYPE_SYNCHRO)
	Duel.Release(g,REASON_COST)
end
function c21879581.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(0)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e2,tp)
end
