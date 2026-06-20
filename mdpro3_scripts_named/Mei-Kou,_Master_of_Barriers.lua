--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 结界术师 明孔  (ID: 47731128)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1700 | DEF 600
--
-- Effect Text:
-- 把这张卡解放发动。场上表侧表示存在的1张永续魔法或者永续陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--結界術師 メイコウ
function c47731128.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47731128,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c47731128.cost)
	e1:SetTarget(c47731128.target)
	e1:SetOperation(c47731128.operation)
	c:RegisterEffect(e1)
end
function c47731128.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c47731128.filter(c)
	local tpe=c:GetType()
	return c:IsFaceup() and (tpe==0x20002 or bit.band(tpe,0x20004)==0x20004)
end
function c47731128.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c47731128.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c47731128.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c47731128.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c47731128.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
