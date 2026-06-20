--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 天刑王 黑天  (ID: 75326861)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- ATK 2800 | DEF 2300
--
-- Effect Text:
-- 恶魔族调整＋调整以外的恶魔族怪兽1只以上
-- 只要这张卡在场上表侧表示存在，双方不能同调召唤。1回合1次，选择有装备卡装备的1只对方怪兽才能发动。选择的怪兽装备的装备卡全部破坏，给与对方基本分破坏数量×400的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--天刑王 ブラック・ハイランダー
function c75326861.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FIEND),aux.NonTuner(Card.IsRace,RACE_FIEND),1)
	c:EnableReviveLimit()
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c75326861.splimit)
	c:RegisterEffect(e1)
	--send to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75326861,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c75326861.target)
	e2:SetOperation(c75326861.operation)
	c:RegisterEffect(e2)
end
function c75326861.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO
end
function c75326861.filter(c)
	return c:GetEquipCount()>0
end
function c75326861.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c75326861.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75326861.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g=Duel.SelectTarget(tp,c75326861.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local eqg=g:GetFirst():GetEquipGroup()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eqg,eqg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,eqg:GetCount()*400)
end
function c75326861.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local eqg=tc:GetEquipGroup()
		if eqg:GetCount()>0 then
			local des=Duel.Destroy(eqg,REASON_EFFECT)
			Duel.Damage(1-tp,des*400,REASON_EFFECT)
		end
	end
end
