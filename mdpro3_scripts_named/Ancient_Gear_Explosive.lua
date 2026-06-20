--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 古代的机械爆弹  (ID: 4446672)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 7
--
-- Effect Text:
-- 把自己场上表侧表示存在的1只名字带有「古代的机械」的怪兽作为对象才能发动。对象的怪兽破坏，给与对方基本分那只怪兽的原本攻击力一半数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--古代の機械爆弾
function c4446672.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c4446672.target)
	e1:SetOperation(c4446672.activate)
	c:RegisterEffect(e1)
end
function c4446672.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x7)
end
function c4446672.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c4446672.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c4446672.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c4446672.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c4446672.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,math.floor(tc:GetBaseAttack()/2),REASON_EFFECT)
		end
	end
end
