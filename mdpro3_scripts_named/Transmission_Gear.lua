--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 变则齿轮  (ID: 58297729)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己怪兽和对方怪兽进行战斗的伤害计算时才能发动。和对方玩家进行猜拳。平局的场合重新猜拳。输的玩家必须把那只进行战斗的自身怪兽里侧表示除外。
--[[ __CARD_HEADER_END__ ]]

--変則ギア
function c58297729.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetTarget(c58297729.target)
	e1:SetOperation(c58297729.activate)
	c:RegisterEffect(e1)
end
function c58297729.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if chk==0 then return d and a:GetControler()~=d:GetControler()
		and a:IsAbleToRemove(a:GetControler(),POS_FACEDOWN,REASON_RULE) and d:IsAbleToRemove(d:GetControler(),POS_FACEDOWN,REASON_RULE) end
end
function c58297729.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() then return end
	if a:IsControler(1-tp) then a,d=d,a end
	local res=Duel.RockPaperScissors()
	if res==tp then
		Duel.Remove(d,POS_FACEDOWN,REASON_RULE)
	else
		Duel.Remove(a,POS_FACEDOWN,REASON_RULE)
	end
end
