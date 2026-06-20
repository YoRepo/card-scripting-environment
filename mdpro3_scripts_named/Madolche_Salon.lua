--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔偶甜点沙龙  (ID: 71348837)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 113
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在魔法与陷阱区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「魔偶甜点」怪兽召唤。
-- ②：这张卡在魔法与陷阱区域存在的状态，自己的场上（表侧表示）·墓地的「魔偶甜点」卡因效果回到自己的手卡·卡组的场合发动。从卡组把「魔偶甜点沙龙」以外的1张「魔偶甜点」魔法·陷阱卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--マドルチェ・サロン
function c71348837.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(71348837,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x71))
	c:RegisterEffect(e2)
	--set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(71348837,1))
	e3:SetCategory(CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,71348837)
	e3:SetCondition(c71348837.secon)
	e3:SetOperation(c71348837.seop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e4)
end
function c71348837.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousControler(tp)
		and (c:IsPreviousLocation(LOCATION_GRAVE) or (c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)))
		and c:IsSetCard(0x71) and not c:IsLocation(LOCATION_EXTRA)
end
function c71348837.secon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and eg:IsExists(c71348837.cfilter,1,nil,tp)
end
function c71348837.sefilter(c)
	return c:IsSetCard(0x71) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable() and not c:IsCode(71348837)
end
function c71348837.seop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c71348837.sefilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
	end
end
