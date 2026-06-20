--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 元素吸收器  (ID: 94253609)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把手卡1张怪兽卡从游戏中除外。持有和这个效果除外的怪兽卡相同的属性的对方怪兽，只要这张卡在场上存在不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--エレメンタル・アブソーバー
function c94253609.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c94253609.cost)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c94253609.atktarget)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c94253609.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c94253609.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94253609.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c94253609.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	local att=g:GetFirst():GetAttribute()
	e:GetLabelObject():SetLabel(att)
	e:GetHandler():SetHint(CHINT_ATTRIBUTE,att)
end
function c94253609.atktarget(e,c)
	return c:IsAttribute(e:GetLabel())
end
