--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 傀儡植物  (ID: 51119924)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 3
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- 把这张卡从手卡丢弃去墓地。直到这个回合的结束阶段时，得到对方场上表侧表示存在的1只战士族或者魔法师族怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--パペット・プラント
function c51119924.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51119924,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c51119924.cost)
	e1:SetTarget(c51119924.target)
	e1:SetOperation(c51119924.operation)
	c:RegisterEffect(e1)
end
function c51119924.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c51119924.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR+RACE_SPELLCASTER) and c:IsControlerCanBeChanged()
end
function c51119924.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c51119924.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51119924.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c51119924.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c51119924.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRace(RACE_WARRIOR+RACE_SPELLCASTER) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
