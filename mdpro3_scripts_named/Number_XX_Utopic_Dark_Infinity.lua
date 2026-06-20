--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: No.XX 无限之达克霍普  (ID: 21858819)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Warrior
-- Rank 10
-- ATK 4000 | DEF 4000
-- Setcode: 8323144
--
-- Effect Text:
-- 10星怪兽×2只以上
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己或者对方的怪兽被战斗破坏送去墓地时，把这张卡1个超量素材取除，以那1只怪兽为对象才能发动。那只怪兽在自己场上守备表示特殊召唤。
-- ②：以这张卡以外的自己场上1只特殊召唤的表侧表示怪兽为对象才能发动。自己基本分回复那只怪兽的原本攻击力的数值。
--[[ __CARD_HEADER_END__ ]]

--No.XX インフィニティ・ダークホープ
function c21858819.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,2,nil,nil,99)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21858819,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,21858819)
	e1:SetCost(c21858819.cost)
	e1:SetTarget(c21858819.target)
	e1:SetOperation(c21858819.activate)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21858819,1))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,21858820)
	e2:SetTarget(c21858819.rectg)
	e2:SetOperation(c21858819.recop)
	c:RegisterEffect(e2)
end
function c21858819.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c21858819.filter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE)
		and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c21858819.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=eg:Filter(c21858819.filter,nil,e,tp)
		e:SetLabelObject(g:GetFirst())
		return g:GetCount()~=0
	end
	Duel.SetTargetCard(e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetLabelObject(),1,0,0)
end
function c21858819.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c21858819.recfilter(c)
	return c:IsFaceup() and c:GetBaseAttack()>0 and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c21858819.rectg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc~=c and chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c21858819.recfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c21858819.recfilter,tp,LOCATION_MZONE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c21858819.recfilter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetBaseAttack())
end
function c21858819.recop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetBaseAttack()>0 then
		Duel.Recover(tp,tc:GetBaseAttack(),REASON_EFFECT)
	end
end
