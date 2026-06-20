--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 黑翼音速  (ID: 72930878)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的怪兽只有「黑羽」怪兽3只的场合，这张卡的发动从手卡也能用。
-- ①：对方怪兽向自己场上的「黑羽」怪兽攻击宣言时才能发动。对方场上的表侧攻击表示怪兽全部除外。
--[[ __CARD_HEADER_END__ ]]

--ブラック・ソニック
function c72930878.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c72930878.condition)
	e1:SetTarget(c72930878.target)
	e1:SetOperation(c72930878.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72930878,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c72930878.handcon)
	c:RegisterEffect(e2)
end
function c72930878.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x33)
end
function c72930878.handcon(e)
	local g=Duel.GetFieldGroup(e:GetHandlerPlayer(),LOCATION_MZONE,0)
	return g:GetCount()==3 and g:IsExists(c72930878.cfilter,3,nil)
end
function c72930878.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsFaceup() and tc:IsControler(tp) and tc:IsSetCard(0x33)
end
function c72930878.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsAbleToRemove()
end
function c72930878.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72930878.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c72930878.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c72930878.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c72930878.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
