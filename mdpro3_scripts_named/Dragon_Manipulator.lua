--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 龙骑手  (ID: 63018132)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 700 | DEF 800
--
-- Effect Text:
-- 反转：在回合结束前得到对方场上的1只表侧表示存在的龙族怪兽。
--[[ __CARD_HEADER_END__ ]]

--ドラゴン・ライダー
function c63018132.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63018132,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c63018132.target)
	e1:SetOperation(c63018132.operation)
	c:RegisterEffect(e1)
end
function c63018132.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsAbleToChangeControler()
end
function c63018132.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c63018132.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c63018132.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c63018132.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
