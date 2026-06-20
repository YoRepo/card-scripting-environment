--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 书灵师·死亡经纪人  (ID: 71406430)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2500 | DEF 2000
-- Setcode: 380
--
-- Effect Text:
-- 「书灵师」卡降临。这个卡名的②③的效果1回合各能使用1次。
-- ①：使用场上的怪兽作仪式召唤的这张卡可以直接攻击。
-- ②：自己主要阶段才能发动。从卡组选1张「书灵师」陷阱卡在自己的魔法与陷阱区域盖放。
-- ③：这张卡给与对方战斗伤害时，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--リブロマンサー・デスブローカー
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--Ritual mats
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(s.matcheck)
	c:RegisterEffect(e1)
	--direct atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(s.matcon)
	c:RegisterEffect(e2)
	--set trap from deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id)
	e3:SetTarget(s.settg)
	e3:SetOperation(s.setop)
	c:RegisterEffect(e3)
	--shuffle face-up opp monster to deck
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCountLimit(1,id+o)
	e4:SetCondition(s.f2dcon)
	e4:SetTarget(s.f2dtg)
	e4:SetOperation(s.f2dop)
	c:RegisterEffect(e4)
end
function s.matcheck(e,c)
	if c:GetMaterial():IsExists(Card.IsLocation,1,nil,LOCATION_MZONE) then
		local reset=RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD
		c:RegisterFlagEffect(id,reset,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(id,0))
	end
end
function s.matcon(e)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_RITUAL) and c:GetFlagEffect(id)>0
end
function s.setfilter(c)
	return c:IsSetCard(0x17c) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,s.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SSet(tp,g)
	end
end
function s.f2dcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp
end
function s.f2dtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(aux.AND(Card.IsFaceup,Card.IsAbleToDeck),tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,aux.AND(Card.IsFaceup,Card.IsAbleToDeck),tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function s.f2dop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
