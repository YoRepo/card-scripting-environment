--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 幻角兽  (ID: 20351153)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level 4
-- ATK 1400 | DEF 600
--
-- Effect Text:
-- 对方场上有怪兽存在，自己场上没有怪兽存在的场合这张卡召唤成功时，可以选择场上盖放的1张魔法·陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--幻角獣フュプノコーン
function c20351153.initial_effect(c)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20351153,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c20351153.descon)
	e3:SetTarget(c20351153.destg)
	e3:SetOperation(c20351153.desop)
	c:RegisterEffect(e3)
end
function c20351153.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<=1 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c20351153.filter(c)
	return c:IsFacedown()
end
function c20351153.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c20351153.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20351153.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c20351153.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c20351153.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
