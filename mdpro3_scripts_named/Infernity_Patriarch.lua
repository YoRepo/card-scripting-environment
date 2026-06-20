--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 永火主教  (ID: 54320860)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1000 | DEF 2000
-- Setcode: 11
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：自己手卡只有这1张卡的场合，这张卡可以从手卡特殊召唤。
-- ②：只要自己手卡是0张，自己场上的「永火」怪兽被战斗·效果破坏的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・ビショップ
function c54320860.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,54320860+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c54320860.spcon)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c54320860.reptg)
	e2:SetValue(c54320860.repval)
	e2:SetOperation(c54320860.repop)
	c:RegisterEffect(e2)
end
function c54320860.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)==1
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c54320860.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsSetCard(0xb) and not c:IsReason(REASON_REPLACE)
end
function c54320860.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
		and eg:IsExists(c54320860.filter,1,nil,tp) and e:GetHandler():IsAbleToRemove() end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c54320860.repval(e,c)
	return c54320860.filter(c,e:GetHandlerPlayer())
end
function c54320860.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
end
