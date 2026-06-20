--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 电虫  (ID: 24725825)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 62
--
-- Effect Text:
-- ①：把这张卡从手卡丢弃去墓地，以对方场上1只龙族·机械族怪兽为对象才能发动。那只龙族·机械族怪兽的控制权直到结束阶段得到。
--[[ __CARD_HEADER_END__ ]]

--エレクトリック・ワーム
function c24725825.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24725825,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c24725825.cost)
	e1:SetTarget(c24725825.target)
	e1:SetOperation(c24725825.operation)
	c:RegisterEffect(e1)
end
function c24725825.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c24725825.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE+RACE_DRAGON) and c:IsControlerCanBeChanged()
end
function c24725825.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c24725825.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c24725825.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c24725825.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c24725825.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRace(RACE_MACHINE+RACE_DRAGON) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
