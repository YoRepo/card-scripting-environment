--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 火焰之魂  (ID: 95026693)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方玩家抽1张卡。从自己卡组选择1只炎族怪兽从游戏中除外。给与对方基本分除外怪兽的攻击力一半数值的伤害。这张卡发动的场合，这个回合自己不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--ファイヤー・ソウル
function c95026693.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c95026693.cost)
	e1:SetTarget(c95026693.target)
	e1:SetOperation(c95026693.activate)
	c:RegisterEffect(e1)
end
function c95026693.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c95026693.filter(c)
	return c:IsRace(RACE_PYRO) and c:IsAbleToRemove()
end
function c95026693.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1)
		and Duel.IsExistingMatchingCard(c95026693.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c95026693.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(1-tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c95026693.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		local dam=math.floor(g:GetFirst():GetAttack()/2)
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end
