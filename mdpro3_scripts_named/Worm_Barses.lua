--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 巴尔萨斯异虫  (ID: 15658249)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level 3
-- ATK 1400 | DEF 1500
-- Setcode: 62
--
-- Effect Text:
-- 这张卡召唤成功时，把场上守备表示存在的1只怪兽变成表侧攻击表示。
--[[ __CARD_HEADER_END__ ]]

--ワーム・バルサス
function c15658249.initial_effect(c)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15658249,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c15658249.postg)
	e1:SetOperation(c15658249.posop)
	c:RegisterEffect(e1)
end
function c15658249.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsDefensePos() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsDefensePos,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c15658249.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsDefensePos() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,0,0,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
