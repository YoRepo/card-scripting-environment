--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 急袭猛禽-起翼猎鹰  (ID: 73887236)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Winged Beast
-- Rank 4
-- ATK 100 | DEF 2000
-- Setcode: 186
--
-- Effect Text:
-- 鸟兽族4星怪兽×3
-- ①：这张卡可以向特殊召唤的对方怪兽全部各作1次攻击。
-- ②：1回合1次，把这张卡1个超量素材取除，以对方场上1只特殊召唤的怪兽为对象才能发动。这张卡的攻击力上升作为对象的怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--RR－ライズ・ファルコン
function c73887236.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),4,3)
	c:EnableReviveLimit()
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(c73887236.atkfilter)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(73887236,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c73887236.cost)
	e2:SetTarget(c73887236.target)
	e2:SetOperation(c73887236.operation)
	c:RegisterEffect(e2)
end
function c73887236.atkfilter(e,c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c73887236.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c73887236.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
		and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c73887236.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c73887236.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c73887236.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c73887236.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c73887236.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
