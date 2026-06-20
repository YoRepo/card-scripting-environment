--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 笑容药水  (ID: 16720314)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 293
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上没有怪兽存在，持有比原本攻击力高的攻击力的怪兽在对方场上存在的场合才能发动。自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--スマイル・ポーション
function c16720314.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,16720314+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c16720314.condition)
	e1:SetTarget(c16720314.target)
	e1:SetOperation(c16720314.activate)
	c:RegisterEffect(e1)
end
function c16720314.cfilter(c)
	return c:IsFaceup() and c:GetAttack()>c:GetBaseAttack()
end
function c16720314.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.IsExistingMatchingCard(c16720314.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c16720314.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c16720314.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
