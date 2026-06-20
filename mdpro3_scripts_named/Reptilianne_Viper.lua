--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 爬虫妖蛇  (ID: 42303365)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Reptile
-- Level 2
-- ATK 0 | DEF 0
-- Setcode: 60
--
-- Effect Text:
-- ①：这张卡召唤成功时，以对方场上1只攻击力0的怪兽为对象才能发动。得到那只攻击力0的怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--レプティレス・バイパー
function c42303365.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42303365,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetTarget(c42303365.ctltg)
	e1:SetOperation(c42303365.ctlop)
	c:RegisterEffect(e1)
end
function c42303365.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() and c:IsAttack(0)
end
function c42303365.ctltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c42303365.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42303365.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c42303365.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c42303365.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttack(0) then
		Duel.GetControl(tc,tp)
	end
end
