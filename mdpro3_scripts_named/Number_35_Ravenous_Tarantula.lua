--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: No.35 极饿捕鸟蛛  (ID: 90162951)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Insect
-- Rank 10
-- ATK 0 | DEF 0
-- Setcode: 72
--
-- Effect Text:
-- 10星怪兽×2
-- ①：只要这张卡在怪兽区域存在，自己场上的怪兽的攻击力·守备力上升自己和对方的基本分差的数值。
-- ②：只要持有超量素材的这张卡在怪兽区域存在，每次对方把怪兽特殊召唤给与对方600伤害。
-- ③：1回合1次，把这张卡1个超量素材取除才能发动。持有这张卡的攻击力以下的攻击力的对方场上的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--No.35 ラベノス・タランチュラ
function c90162951.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,2)
	c:EnableReviveLimit()
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetValue(c90162951.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c90162951.damcon)
	e3:SetOperation(c90162951.damop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90162951,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c90162951.descost)
	e4:SetTarget(c90162951.destg)
	e4:SetOperation(c90162951.desop)
	c:RegisterEffect(e4)
end
aux.xyz_number[90162951]=35
function c90162951.val(e,c)
	return math.abs(Duel.GetLP(0)-Duel.GetLP(1))
end
function c90162951.cfilter(c,tp)
	return c:IsSummonPlayer(tp)
end
function c90162951.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetOverlayCount()>0 and eg:IsExists(c90162951.cfilter,1,nil,1-tp)
end
function c90162951.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,90162951)
	Duel.Damage(1-tp,600,REASON_EFFECT)
end
function c90162951.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c90162951.desfilter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk)
end
function c90162951.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c90162951.desfilter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack()) end
	local g=Duel.GetMatchingGroup(c90162951.desfilter,tp,0,LOCATION_MZONE,nil,c:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c90162951.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c90162951.desfilter,tp,0,LOCATION_MZONE,nil,c:GetAttack())
	Duel.Destroy(g,REASON_EFFECT)
end
