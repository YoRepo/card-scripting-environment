--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 超量热战！！  (ID: 57319935)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 115
--
-- Effect Text:
-- 自己场上的超量怪兽被战斗破坏时，支付1000基本分才能发动。双方玩家从各自的额外卡组选持有破坏的怪兽的阶级以下的阶级的1只超量怪兽给对方观看。把攻击力低的怪兽给人观看的玩家受到对方给人观看的怪兽的攻击
-- 力和自己给人观看的怪兽的攻击力的相差数值的伤害。对方没把怪兽给人观看的场合，给与对方基本分自己给人观看的怪兽的攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--エクシーズ熱戦！！
function c57319935.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c57319935.condition)
	e1:SetCost(c57319935.cost)
	e1:SetTarget(c57319935.target)
	e1:SetOperation(c57319935.activate)
	c:RegisterEffect(e1)
end
function c57319935.cfilter(c,tp)
	return c:IsType(TYPE_XYZ) and c:IsPreviousControler(tp)
end
function c57319935.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if c57319935.cfilter(tc,tp) then
		e:SetLabel(tc:GetRank())
		return true
	end
	tc=eg:GetNext()
	if tc and c57319935.cfilter(tc,tp) then
		e:SetLabel(tc:GetRank())
		return true
	end
	return false
end
function c57319935.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c57319935.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsRankBelow,tp,LOCATION_EXTRA,0,1,nil,e:GetLabel()) end
end
function c57319935.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(57319935,0))
	local tc1=Duel.SelectMatchingCard(tp,Card.IsRankBelow,tp,LOCATION_EXTRA,0,1,1,nil,e:GetLabel()):GetFirst()
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(57319935,0))
	local tc2=Duel.SelectMatchingCard(1-tp,Card.IsRankBelow,1-tp,LOCATION_EXTRA,0,1,1,nil,e:GetLabel()):GetFirst()
	if tc1 and tc2 then
		Duel.ConfirmCards(1-tp,tc1)
		Duel.ConfirmCards(tp,tc2)
		local atk1=tc1:GetAttack()
		local atk2=tc2:GetAttack()
		if atk1>atk2 then
			Duel.Damage(1-tp,atk1-atk2,REASON_EFFECT)
		elseif atk1<atk2 then
			Duel.Damage(tp,atk2-atk1,REASON_EFFECT)
		end
	elseif tc1 then
		Duel.ConfirmCards(1-tp,tc1)
		Duel.Damage(1-tp,tc1:GetAttack(),REASON_EFFECT)
	elseif tc2 then
		Duel.ConfirmCards(tp,tc2)
		Duel.Damage(tp,tc2:GetAttack(),REASON_EFFECT)
	end
end
