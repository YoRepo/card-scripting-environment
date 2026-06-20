--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 波塞冬之浪  (ID: 25642998)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽的攻击宣言时才能发动。把1只对方怪兽的攻击无效。自己场上有鱼族·海龙族·水族怪兽表侧表示存在的场合，给与对方基本分那个数量×800的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ポセイドン・ウェーブ
function c25642998.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c25642998.condition)
	e1:SetTarget(c25642998.target)
	e1:SetOperation(c25642998.activate)
	c:RegisterEffect(e1)
end
function c25642998.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c25642998.dfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA)
end
function c25642998.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	local dam=Duel.GetMatchingGroupCount(c25642998.dfilter,tp,LOCATION_MZONE,0,nil)*800
	if dam>0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
	end
end
function c25642998.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.NegateAttack() then
		local dam=Duel.GetMatchingGroupCount(c25642998.dfilter,tp,LOCATION_MZONE,0,nil)*800
		if dam>0 then
			Duel.Damage(1-tp,dam,REASON_EFFECT)
		end
	end
end
