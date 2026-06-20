--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 焰圣骑士将-奥利佛  (ID: 65398390)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Warrior
-- Level 5
-- ATK 2000 | DEF 500
-- Setcode: 20602
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：有装备卡装备的这张卡的攻击宣言时，以场上1张表侧表示的卡为对象才能发动。那张卡破坏。
-- ②：以自己场上1只战士族怪兽为对象才能发动。这张卡当作调整使用从墓地特殊召唤，作为对象的自己怪兽当作攻击力上升500的装备卡使用给这张卡装备。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--焔聖騎士将－オリヴィエ
function c65398390.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65398390,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c65398390.descon)
	e1:SetTarget(c65398390.destg)
	e1:SetOperation(c65398390.desop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65398390,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,65398390)
	e2:SetCondition(aux.exccon)
	e2:SetTarget(c65398390.sptg)
	e2:SetOperation(c65398390.spop)
	c:RegisterEffect(e2)
end
c65398390.treat_itself_tuner=true
function c65398390.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipCount()>0
end
function c65398390.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c65398390.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c65398390.eqfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR)
end
function c65398390.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c65398390.eqfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c65398390.eqfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c65398390.eqfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c65398390.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) then
		local res=Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP)
		if res then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_ADD_TYPE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(TYPE_TUNER)
			c:RegisterEffect(e1)
		end
		Duel.SpecialSummonComplete()
		if res and tc:IsRelateToEffect(e) and tc:IsControler(tp) then
			if not Duel.Equip(tp,tc,c,false) then return end
			--equip limit
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e2:SetCode(EFFECT_EQUIP_LIMIT)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			e2:SetLabelObject(c)
			e2:SetValue(c65398390.eqlimit)
			tc:RegisterEffect(e2)
			--atk up
			local e3=Effect.CreateEffect(tc)
			e3:SetType(EFFECT_TYPE_EQUIP)
			e3:SetCode(EFFECT_UPDATE_ATTACK)
			e3:SetValue(500)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e3)
		end
	end
end
function c65398390.eqlimit(e,c)
	return c==e:GetLabelObject()
end
