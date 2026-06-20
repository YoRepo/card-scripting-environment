--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 先史遗产 巨石人头像  (ID: 52158283)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 800 | DEF 1600
-- Setcode: 112
--
-- Effect Text:
-- 把墓地的这张卡从游戏中除外，选择场上攻击表示存在的1只3星以上的怪兽才能发动。选择的怪兽变成表侧守备表示或者里侧守备表示。「先史遗产 巨石人头像」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--先史遺産コロッサル・ヘッド
function c52158283.initial_effect(c)
	--adchange
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52158283,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,52158283)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c52158283.target)
	e1:SetOperation(c52158283.operation)
	c:RegisterEffect(e1)
end
function c52158283.filter(c)
	return c:IsAttackPos() and c:IsLevelAbove(3)
end
function c52158283.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c52158283.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c52158283.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c52158283.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c52158283.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if tc:IsAttackPos() then
			local pos=0
			if tc:IsCanTurnSet() then
				pos=Duel.SelectPosition(tp,tc,POS_DEFENSE)
			else
				pos=Duel.SelectPosition(tp,tc,POS_FACEUP_DEFENSE)
			end
			Duel.ChangePosition(tc,pos)
		else
			Duel.ChangePosition(tc,0,0,POS_FACEDOWN_DEFENSE,POS_FACEUP_DEFENSE)
		end
	end
end
