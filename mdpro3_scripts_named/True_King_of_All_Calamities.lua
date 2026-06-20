--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 真龙皇 法·王·兽  (ID: 88581108)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Wyrm
-- Rank 9
-- ATK 3000 | DEF 3000
-- Setcode: 249
--
-- Effect Text:
-- 9星怪兽×2只以上
-- ①：1回合1次，把这张卡1个超量素材取除，宣言1个属性才能发动。这个回合，以下效果适用。这个效果在对方回合也能发动。
-- ●场上的表侧表示怪兽变成宣言的属性，宣言的属性的对方怪兽不能攻击，不能把效果发动。
-- ②：只要这张卡在怪兽区域存在，自己手卡的「真龙」怪兽的效果破坏的怪兽从对方场上也能选。
--[[ __CARD_HEADER_END__ ]]

--真竜皇V.F.D.
function c88581108.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2,nil,nil,99)
	c:EnableReviveLimit()
	--attribute change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88581108,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	e1:SetCost(c88581108.atcost)
	e1:SetTarget(c88581108.attg)
	e1:SetOperation(c88581108.atop)
	c:RegisterEffect(e1)
	--true king destruction
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(88581108)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
end
function c88581108.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c88581108.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local rc=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL)
	e:SetLabel(rc)
end
function c88581108.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(e:GetLabel())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetTargetRange(0,1)
	e2:SetLabel(e:GetLabel())
	e2:SetValue(c88581108.aclimit)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetLabel(e:GetLabel())
	e3:SetTarget(c88581108.atktarget)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c88581108.aclimit(e,re,tp)
	local c=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and c:IsAttribute(e:GetLabel())
end
function c88581108.atktarget(e,c)
	return c:IsAttribute(e:GetLabel())
end
