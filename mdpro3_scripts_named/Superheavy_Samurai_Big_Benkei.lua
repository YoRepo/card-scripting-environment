--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 超重武者 大弁庆-K  (ID: 3117804)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 8
-- ATK 1000 | DEF 3500
-- Setcode: 154
--
-- Effect Text:
-- ①：这张卡召唤·特殊召唤成功时才能发动。这张卡的表示形式变更。
-- ②：只要这张卡在怪兽区域存在，自己的「超重武者」怪兽可以用表侧守备表示的状态作出攻击。那个场合，那怪兽用守备力当作攻击力使用进行伤害计算。
--[[ __CARD_HEADER_END__ ]]

--超重武者ビッグベン－K
function c3117804.initial_effect(c)
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3117804,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetOperation(c3117804.posop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DEFENSE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c3117804.atktg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c3117804.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
function c3117804.atktg(e,c)
	return c:IsSetCard(0x9a)
end
