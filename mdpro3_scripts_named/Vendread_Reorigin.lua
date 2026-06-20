--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 复仇死者的还魂再生  (ID: 30650147)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 262
--
-- Effect Text:
-- ①：以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽解放，把持有和那个原本等级相同等级的1只「复仇死者衍生物」（不死族·暗·攻/守0）在自己场上特殊召唤。只要这个效果特殊召唤的衍生物在怪兽区域存在，
-- 自己不是「复仇死者」怪兽不能召唤·特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ヴェンデット・リボーン
function c30650147.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c30650147.target)
	e1:SetOperation(c30650147.activate)
	c:RegisterEffect(e1)
end
function c30650147.filter(c,tp)
	return c:IsFaceup() and c:GetOriginalLevel()>0 and c:IsReleasableByEffect()
		and Duel.IsPlayerCanSpecialSummonMonster(tp,30650148,0x106,TYPES_TOKEN_MONSTER,0,0,c:GetOriginalLevel(),RACE_ZOMBIE,ATTRIBUTE_DARK)
end
function c30650147.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c30650147.filter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c30650147.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	Duel.SelectTarget(tp,c30650147.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c30650147.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Release(tc,REASON_EFFECT)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local token=Duel.CreateToken(tp,30650148)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetAbsoluteRange(tp,1,0)
		e1:SetTarget(c30650147.splimit)
		token:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_SUMMON)
		token:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(tc:GetOriginalLevel())
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		token:RegisterEffect(e3,true)
		Duel.SpecialSummonComplete()
	end
end
function c30650147.splimit(e,c)
	return not c:IsSetCard(0x106)
end
